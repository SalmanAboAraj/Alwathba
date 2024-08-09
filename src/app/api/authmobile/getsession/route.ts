import { getServerAuthSession } from "@/server/auth";
import { db } from "@/server/db";
import { user } from "@/server/db/schema";
import { eq, ne } from "drizzle-orm";
import { NextRequest, NextResponse } from "next/server";

export const GET = async (request: NextRequest) => {
  try {
    const session = await getServerAuthSession();
    return new Response(JSON.stringify(session), { status: 200 });
  } catch (error) {
    console.log(error);
    return new Response("Something went wrong", { status: 500 });
  }
};
