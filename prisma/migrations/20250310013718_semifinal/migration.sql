/*
  Warnings:

  - You are about to drop the `Equipement_Intervention` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Equipements` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Intervenant` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Interventions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Roles` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Type_Equipement` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Utilisateurs` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `history_interventions` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "Priority" AS ENUM ('LOW', 'MEDIUM', 'HIGH');

-- CreateEnum
CREATE TYPE "InterventionStatus" AS ENUM ('PENDING', 'IN_PROGRESS', 'COMPLETED');

-- CreateEnum
CREATE TYPE "EquipmentStatus" AS ENUM ('IN_SERVICE', 'OUT_OF_SERVICE', 'UNDER_MAINTENANCE');

-- DropForeignKey
ALTER TABLE "Equipement_Intervention" DROP CONSTRAINT "Equipement_Intervention_equipement_id_fkey";

-- DropForeignKey
ALTER TABLE "Equipement_Intervention" DROP CONSTRAINT "Equipement_Intervention_intervention_id_fkey";

-- DropForeignKey
ALTER TABLE "Equipements" DROP CONSTRAINT "Equipements_type_id_fkey";

-- DropForeignKey
ALTER TABLE "Intervenant" DROP CONSTRAINT "Intervenant_user_id_fkey";

-- DropForeignKey
ALTER TABLE "Interventions" DROP CONSTRAINT "Interventions_assigned_to_id_fkey";

-- DropForeignKey
ALTER TABLE "Interventions" DROP CONSTRAINT "Interventions_reported_by_id_fkey";

-- DropForeignKey
ALTER TABLE "Utilisateurs" DROP CONSTRAINT "Utilisateurs_role_id_fkey";

-- DropForeignKey
ALTER TABLE "history_interventions" DROP CONSTRAINT "history_interventions_intervention_id_fkey";

-- DropForeignKey
ALTER TABLE "history_interventions" DROP CONSTRAINT "history_interventions_logged_by_fkey";

-- DropTable
DROP TABLE "Equipement_Intervention";

-- DropTable
DROP TABLE "Equipements";

-- DropTable
DROP TABLE "Intervenant";

-- DropTable
DROP TABLE "Interventions";

-- DropTable
DROP TABLE "Roles";

-- DropTable
DROP TABLE "Type_Equipement";

-- DropTable
DROP TABLE "Utilisateurs";

-- DropTable
DROP TABLE "history_interventions";

-- DropEnum
DROP TYPE "EtatEnum";

-- CreateTable
CREATE TABLE "Role" (
    "role_id" SERIAL NOT NULL,
    "name" VARCHAR(50) NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("role_id")
);

-- CreateTable
CREATE TABLE "UserAccount" (
    "user_id" SERIAL NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "passwordHash" VARCHAR(255),
    "googleId" VARCHAR(255),
    "role_id" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "UserAccount_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "Person" (
    "person_id" SERIAL NOT NULL,
    "fullName" VARCHAR(255) NOT NULL,
    "email" VARCHAR(255),
    "phoneNumber" VARCHAR(20),
    "department" VARCHAR(100),
    "userAccountId" INTEGER,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "isTechnician" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Person_pkey" PRIMARY KEY ("person_id")
);

-- CreateTable
CREATE TABLE "Intervention" (
    "intervention_id" SERIAL NOT NULL,
    "description" TEXT NOT NULL,
    "priority" "Priority" NOT NULL DEFAULT 'MEDIUM',
    "status" "InterventionStatus" NOT NULL DEFAULT 'PENDING',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "resolvedAt" TIMESTAMP(3),
    "reportedById" INTEGER NOT NULL,
    "assignedToId" INTEGER,
    "equipment_id" INTEGER NOT NULL,

    CONSTRAINT "Intervention_pkey" PRIMARY KEY ("intervention_id")
);

-- CreateTable
CREATE TABLE "Equipment" (
    "equipment_id" SERIAL NOT NULL,
    "inventory_code" VARCHAR(50) NOT NULL,
    "designation" VARCHAR(255) NOT NULL,
    "status" "EquipmentStatus" NOT NULL DEFAULT 'IN_SERVICE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "type_id" INTEGER,

    CONSTRAINT "Equipment_pkey" PRIMARY KEY ("equipment_id")
);

-- CreateTable
CREATE TABLE "equipment_types" (
    "type_id" SERIAL NOT NULL,
    "type_name" VARCHAR(255) NOT NULL,
    "category" VARCHAR(255) NOT NULL,

    CONSTRAINT "equipment_types_pkey" PRIMARY KEY ("type_id")
);

-- CreateTable
CREATE TABLE "intervention_history" (
    "history_id" SERIAL NOT NULL,
    "intervention_id" INTEGER NOT NULL,
    "action" TEXT NOT NULL,
    "parts_used" TEXT,
    "notes" TEXT,
    "logged_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "logged_by_id" INTEGER NOT NULL,
    "user_account_id" INTEGER,

    CONSTRAINT "intervention_history_pkey" PRIMARY KEY ("history_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Role_name_key" ON "Role"("name");

-- CreateIndex
CREATE INDEX "Role_name_idx" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "UserAccount_email_key" ON "UserAccount"("email");

-- CreateIndex
CREATE UNIQUE INDEX "UserAccount_googleId_key" ON "UserAccount"("googleId");

-- CreateIndex
CREATE INDEX "UserAccount_email_idx" ON "UserAccount"("email");

-- CreateIndex
CREATE INDEX "UserAccount_googleId_idx" ON "UserAccount"("googleId");

-- CreateIndex
CREATE UNIQUE INDEX "Person_userAccountId_key" ON "Person"("userAccountId");

-- CreateIndex
CREATE INDEX "Person_fullName_idx" ON "Person"("fullName");

-- CreateIndex
CREATE INDEX "Person_email_idx" ON "Person"("email");

-- CreateIndex
CREATE INDEX "Intervention_status_idx" ON "Intervention"("status");

-- CreateIndex
CREATE INDEX "Intervention_priority_idx" ON "Intervention"("priority");

-- CreateIndex
CREATE INDEX "Intervention_createdAt_idx" ON "Intervention"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "Equipment_inventory_code_key" ON "Equipment"("inventory_code");

-- CreateIndex
CREATE INDEX "Equipment_inventory_code_idx" ON "Equipment"("inventory_code");

-- CreateIndex
CREATE INDEX "Equipment_status_idx" ON "Equipment"("status");

-- CreateIndex
CREATE UNIQUE INDEX "equipment_types_type_name_key" ON "equipment_types"("type_name");

-- AddForeignKey
ALTER TABLE "UserAccount" ADD CONSTRAINT "UserAccount_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Role"("role_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_userAccountId_fkey" FOREIGN KEY ("userAccountId") REFERENCES "UserAccount"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_reportedById_fkey" FOREIGN KEY ("reportedById") REFERENCES "UserAccount"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "Person"("person_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervention" ADD CONSTRAINT "Intervention_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "Equipment"("equipment_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipment" ADD CONSTRAINT "Equipment_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "equipment_types"("type_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intervention_history" ADD CONSTRAINT "intervention_history_intervention_id_fkey" FOREIGN KEY ("intervention_id") REFERENCES "Intervention"("intervention_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intervention_history" ADD CONSTRAINT "intervention_history_logged_by_id_fkey" FOREIGN KEY ("logged_by_id") REFERENCES "Person"("person_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "intervention_history" ADD CONSTRAINT "intervention_history_user_account_id_fkey" FOREIGN KEY ("user_account_id") REFERENCES "UserAccount"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;
