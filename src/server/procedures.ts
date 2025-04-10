import { db } from "@/db";
import { j } from "./__internals/j";
import { currentUser } from "@clerk/nextjs/server";
import { HTTPException } from "hono/http-exception";

/**
 * Public (unauthenticated) procedures
 *
 * This is the base piece you use to build new queries and mutations on your API.
 */

const authMiddleware = j.middleware(async ({ c, next }) => {
  try {
    const authHeader = c.req.header("Authorization");

    if (authHeader) {
      const apiKey = authHeader.split(" ")[1]; // Bearer <API_KEY>

      const user = await db.user.findUnique({
        where: { apiKey },
      });

      if (user) {
        return next({ user });
      }
    }

    const auth = await currentUser();

    if (!auth) {
      throw new HTTPException(401, { message: "Unauthorized" });
    }

    const user = await db.user.findUnique({
      where: { externalId: auth.id },
    });

    if (!user) {
      throw new HTTPException(401, { message: "Unauthorized" });
    }

    return next({ user });
  } catch (error) {
    console.error("Error in authMiddleware:", error);
    throw new HTTPException(500, { message: "Internal Server Error" });
  }
});

export const baseProcedure = j.procedure;
export const publicProcedure = baseProcedure;
export const privateProcedure = publicProcedure.use(authMiddleware);
