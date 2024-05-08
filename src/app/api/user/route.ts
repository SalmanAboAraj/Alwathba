import { db } from "@/server/db";
import { user } from "@/server/db/schema";
import { NextRequest, NextResponse } from "next/server";
import { use } from "react";

export async function GET(request: NextRequest) {
  const allUsers = await db.select().from(user);
  return NextResponse.json({ allUsers });
}

export async function POST(request: NextRequest) {
  const newUser = await request.json();
  const createUser = await db.insert(user).values(newUser);
  return NextResponse.json({});
}
