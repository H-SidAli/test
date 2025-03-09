const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function createEquipement(data) {
    return await prisma.equipement.create({
        data: {
            codeInventaire: parseInt(data.codeInventaire),
            designation: data.designation,
            affectation: data.affectation,
            typeId: parseInt(data.typeId),
            etat: data.etat,
            misEnService: new Date(data.misEnService),
            dateAcquisition: new Date(data.dateAcquisition),
        },
        include: {
            type: true, // Include the equipment type in the response
        },
    });
}

async function getEquipements(){
    return await prisma.equipement.findMany({
        include: {
            type: true, // Include the equipment type in the response
        },
    });
}

async function getEquipementById(equipementId){
    return await prisma.equipement.findUnique(
        {
            where: {
                codeInventaire: parseInt(equipementId),
            },
            include: {
                type: true, // Include the equipment type in the response
            }
        }
    );
}

module.exports = { createEquipement , getEquipements , getEquipementById};