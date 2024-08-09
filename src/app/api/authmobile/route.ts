import { getServerAuthSession } from "@/server/auth";
import { db } from "@/server/db";
import { user } from "@/server/db/schema";
import { hashSync } from "bcrypt-ts";
import { eq } from "drizzle-orm";
import { signIn } from "next-auth/react";
import { NextRequest, NextResponse } from "next/server";

export async function POST(request: NextRequest) {
  try {
    const req = await request.json();
    console.log(req);
    const res = await signIn("credentials", {
      email: req.email,
      password: req.password,
      redirect: false,
      callbackUrl: "/about",
    });
    console.log(res);
    return NextResponse.json({
      msg: "success",
      token: await getServerAuthSession(),
    });
  } catch (e) {
    console.log(e);
    return NextResponse.json({ msg: "error creating account" });
  }
}
