/*
  Warnings:

  - You are about to drop the column `updatedAt` on the `UserAccount` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Person" DROP CONSTRAINT "Person_userAccountId_fkey";

-- AlterTable
ALTER TABLE "UserAccount" DROP COLUMN "updatedAt";

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_userAccountId_fkey" FOREIGN KEY ("userAccountId") REFERENCES "UserAccount"("user_id") ON DELETE CASCADE ON UPDATE CASCADE;
