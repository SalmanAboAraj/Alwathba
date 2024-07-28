import { db } from "@/server/db";
import { user } from "@/server/db/schema";
import { hashSync } from "bcrypt-ts";
import { NextRequest, NextResponse } from "next/server";

export async function POST(request: NextRequest) {
  try {
    const newuser = await request.json();

    await db.insert(user).values({
      ...newuser,
      password: await hashSync(newuser.password, 10),
      emailResetPassword: null,
      tokenCreatedAt: null,
    });
    return NextResponse.redirect(process.env.NEXTAUTH_URL + "/login", {
      status: 307,
    });
  } catch (e) {
    console.log(e);
    return NextResponse.json({ msg: "error creating account" });
  }
}
