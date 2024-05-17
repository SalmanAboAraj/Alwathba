import { db } from "@/server/db";
import { userMedia } from "@/server/db/schema";
import mime from "mime";
import { join } from "path";
import { stat, mkdir, writeFile } from "fs/promises";
import { NextRequest, NextResponse } from "next/server";

export async function POST(req: NextRequest) {
  const formData = await req.formData();
  const image = formData.get("imagePath") as File;
  const buffer = Buffer.from(await image.arrayBuffer());
  const now = new Date();
  const formattedDate = now.toLocaleDateString("id-ID", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
  const relativeUploadDir = `/uploads/${formattedDate.replace(/[\/\\]/g, "-")}`;

  const uploadDir = join(process.cwd(), "public", relativeUploadDir);

  try {
    await stat(uploadDir);
  } catch (e: any) {
    if (e.code === "ENOENT") {
      await mkdir(uploadDir, { recursive: true });
    } else {
      console.error(
        "Error while trying to create directory when uploading a file\n",
        e,
      );
      return NextResponse.json(
        { error: "Something went wrong." },
        { status: 500 },
      );
    }
  }

  try {
    const uniqueSuffix = `${Date.now()}-${Math.round(Math.random() * 1e9)}`;
    const filename = `${image.name.replace(
      /\.[^/.]+$/,
      "",
    )}-${uniqueSuffix}.${mime.getExtension(image.type)}`;
    await writeFile(`${uploadDir}/${filename}`, buffer);
    const fileUrl = `${relativeUploadDir}/${filename}`;
    const userMediaRow = {
      userId: Number(formData.get("userId")),
      imagePath: fileUrl,
    };
    const createImage = await db.insert(userMedia).values(userMediaRow);

    return NextResponse.json({ user: createImage });
  } catch (e) {
    console.error("Error while trying to upload a file\n", e);
    return NextResponse.json(
      { error: "Something went wrong." },
      { status: 500 },
    );
  }
}
