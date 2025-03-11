const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

// get all interventions
async function getInterventions() {
    return await prisma.intervention.findMany();
}

