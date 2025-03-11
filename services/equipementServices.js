const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

// Create a new equipment
async function createEquipment(data) {
    return await prisma.equipment.create({
        data: {
            inventory_code: data.inventory_code,
            designation: data.designation,
            status: data.status,
            typeId: parseInt(data.typeId),
            acquisitionDate: new Date(data.acquisitionDate),
            commissionDate: new Date(data.commissionDate),
        },
        include: {
            type: true,
        },
    });
}

// Get all equipment
async function getEquipments() {
    return await prisma.equipment.findMany({
        include: {
            type: true,
        },
    });
}

// Get a single equipment by ID
async function getEquipmentById(equipmentId) {
    return await prisma.equipment.findUnique({
        where: {
            equipment_id: parseInt(equipmentId),
        },
        include: {
            type: true,
        },
    });
}

// Delete an equipment by ID
async function deleteEquipment(equipmentId) {
    return await prisma.equipment.delete({
        where: {
            equipment_id: parseInt(equipmentId),
        },
    });
}

// Update equipment details
async function updateEquipment(equipmentId, data) {
    return await prisma.equipment.update({
        where: {
            equipment_id: parseInt(equipmentId),
        },
        data: {
            designation: data.designation,
            status: data.status,
            typeId: parseInt(data.typeId),
            acquisitionDate: new Date(data.acquisitionDate),
            commissionDate: new Date(data.commissionDate),
        },
        include: {
            type: true,
        },
    });
}

module.exports = {
    createEquipment,
    getEquipments,
    getEquipmentById,
    deleteEquipment,
    updateEquipment,
};
