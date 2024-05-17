import { db } from "@/server/db";
import { userMedia } from "@/server/db/schema";
import { NextRequest, NextResponse } from "next/server";
import { eq } from "drizzle-orm";

export async function GET(
  request: NextRequest,
  { params }: { params: { id: string } },
) {
  try {
    const userId = parseInt(params.id, 10);
    const mediaRecords = await db
      .select()
      .from(userMedia)
      .where(eq(userMedia.userId, userId));
    return NextResponse.json({ user: mediaRecords });
  } catch (e) {
    console.error("Error while trying to upload a file\n", e);
    return NextResponse.json(
      { error: "Something went wrong." },
      { status: 500 },
    );
  }
}
