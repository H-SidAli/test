-- CreateEnum
CREATE TYPE "EtatEnum" AS ENUM ('open', 'in_progress', 'resolved');

-- CreateTable
CREATE TABLE "Roles" (
    "role_id" BIGINT NOT NULL,
    "role_name" VARCHAR(50) NOT NULL,

    CONSTRAINT "Roles_pkey" PRIMARY KEY ("role_id")
);

-- CreateTable
CREATE TABLE "Utilisateurs" (
    "user_id" SERIAL NOT NULL,
    "hash_password" VARCHAR(255) NOT NULL,
    "role_id" BIGINT NOT NULL,

    CONSTRAINT "Utilisateurs_pkey" PRIMARY KEY ("user_id")
);

-- CreateTable
CREATE TABLE "Intervenant" (
    "person_id" SERIAL NOT NULL,
    "email" VARCHAR(255) NOT NULL,
    "fullname" VARCHAR(255) NOT NULL,
    "departement" VARCHAR(255) NOT NULL,
    "created_at" TIMESTAMP(0) NOT NULL,
    "job_position" VARCHAR(255) NOT NULL,
    "user_id" INTEGER,

    CONSTRAINT "Intervenant_pkey" PRIMARY KEY ("person_id")
);

-- CreateTable
CREATE TABLE "Interventions" (
    "intervention_id" SERIAL NOT NULL,
    "created_at" TIMESTAMP(0) NOT NULL,
    "resolved_at" TIMESTAMP(0),
    "description" VARCHAR(255) NOT NULL,
    "etat" "EtatEnum" NOT NULL,
    "priority" BIGINT NOT NULL,
    "reported_by_id" INTEGER NOT NULL,
    "assigned_to_id" INTEGER NOT NULL,

    CONSTRAINT "Interventions_pkey" PRIMARY KEY ("intervention_id")
);

-- CreateTable
CREATE TABLE "Equipements" (
    "code_inventaire" BIGINT NOT NULL,
    "designation" VARCHAR(255) NOT NULL,
    "affectation" VARCHAR(255) NOT NULL,
    "type_id" BIGINT NOT NULL,
    "etat" "EtatEnum" NOT NULL,
    "mis_en_service" DATE NOT NULL,
    "date_acquisition" DATE NOT NULL,

    CONSTRAINT "Equipements_pkey" PRIMARY KEY ("code_inventaire")
);

-- CreateTable
CREATE TABLE "Type_Equipement" (
    "type_id" BIGINT NOT NULL,
    "type_name" VARCHAR(255) NOT NULL,
    "category" VARCHAR(255) NOT NULL,

    CONSTRAINT "Type_Equipement_pkey" PRIMARY KEY ("type_id")
);

-- CreateTable
CREATE TABLE "history_interventions" (
    "history_id" SERIAL NOT NULL,
    "intervention_id" INTEGER NOT NULL,
    "action_performed" TEXT NOT NULL,
    "parts_used" TEXT NOT NULL,
    "technician_notes" TEXT NOT NULL,
    "logged_at" TIMESTAMP(0) NOT NULL,
    "logged_by" INTEGER NOT NULL,

    CONSTRAINT "history_interventions_pkey" PRIMARY KEY ("history_id")
);

-- CreateTable
CREATE TABLE "Equipement_Intervention" (
    "equipement_id" BIGINT NOT NULL,
    "intervention_id" INTEGER NOT NULL,

    CONSTRAINT "Equipement_Intervention_pkey" PRIMARY KEY ("equipement_id","intervention_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Intervenant_user_id_key" ON "Intervenant"("user_id");

-- AddForeignKey
ALTER TABLE "Utilisateurs" ADD CONSTRAINT "Utilisateurs_role_id_fkey" FOREIGN KEY ("role_id") REFERENCES "Roles"("role_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Intervenant" ADD CONSTRAINT "Intervenant_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "Utilisateurs"("user_id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interventions" ADD CONSTRAINT "Interventions_reported_by_id_fkey" FOREIGN KEY ("reported_by_id") REFERENCES "Utilisateurs"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Interventions" ADD CONSTRAINT "Interventions_assigned_to_id_fkey" FOREIGN KEY ("assigned_to_id") REFERENCES "Intervenant"("person_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipements" ADD CONSTRAINT "Equipements_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "Type_Equipement"("type_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "history_interventions" ADD CONSTRAINT "history_interventions_intervention_id_fkey" FOREIGN KEY ("intervention_id") REFERENCES "Interventions"("intervention_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "history_interventions" ADD CONSTRAINT "history_interventions_logged_by_fkey" FOREIGN KEY ("logged_by") REFERENCES "Utilisateurs"("user_id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipement_Intervention" ADD CONSTRAINT "Equipement_Intervention_equipement_id_fkey" FOREIGN KEY ("equipement_id") REFERENCES "Equipements"("code_inventaire") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Equipement_Intervention" ADD CONSTRAINT "Equipement_Intervention_intervention_id_fkey" FOREIGN KEY ("intervention_id") REFERENCES "Interventions"("intervention_id") ON DELETE RESTRICT ON UPDATE CASCADE;
