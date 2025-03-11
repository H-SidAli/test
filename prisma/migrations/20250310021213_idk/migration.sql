/*
  Warnings:

  - Made the column `type_id` on table `Equipment` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "Equipment" DROP CONSTRAINT "Equipment_type_id_fkey";

-- DropForeignKey
ALTER TABLE "UserAccount" DROP CONSTRAINT "UserAccount_role_id_fkey";

-- AlterTable
ALTER TABLE "Equipment" ADD COLUMN     "acquisition_date" TIMESTAMP(3),
ADD COLUMN     "commission_date" TIMESTAMP(3),
ALTER COLUMN "type_id" SET NOT NULL;

-- AddForeignKey
ALTER TABLE "UserAccount" ADD CONSTRAINT "UserAccount_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("role_id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipment" ADD CONSTRAINT "Equipment_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "equipment_types"("type_id") ON DELETE RESTRICT ON UPDATE CASCADE;
