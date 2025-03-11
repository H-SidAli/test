const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

async function getAllEquipementTypes() {
    return await prisma.equipmentType.findMany();
}

// createEquipementType
async function createEquipementType(equipementType) {
    return await prisma.equipmentType.create({
        data: {
            name: equipementType.name,
            category: equipementType.category,
        },
    });
}

async function deleteEquipementType(equipementId){
    return await prisma.equipmentType.delete({
        where: {
            id: parseInt(equipementId),
        },  
    })

}

module.exports = { getAllEquipementTypes, createEquipementType , deleteEquipementType};
