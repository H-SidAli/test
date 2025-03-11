const equipementService = require("../services/equipementServices");

// Create Equipment
async function createEquipement(req, res) {
    try {
        const {
            inventory_code,
            designation,
            typeId,
            status,
            commissionDate,
            acquisitionDate,
        } = req.body;

        // Validate required fields
        if (!inventory_code || !designation || !typeId) {
            return res
                .status(400)
                .json({ error: "Required fields are missing" });
        }

        const newEquipement = await equipementService.createEquipment(
            req.body
        );
        res.status(201).json(newEquipement);
    } catch (error) {
        console.error("Error creating equipment:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

// Get All Equipments
async function getEquipements(req, res) {
    try {
        const equipements = await equipementService.getEquipments();
        res.status(200).json(equipements);
    } catch (error) {
        console.error("Error fetching equipment list:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

// Get Equipment by ID
async function getEquipementById(req, res) {
    try {
        const equipementId = parseInt(req.params.id);
        const equipement = await equipementService.getEquipmentById(
            equipementId
        );

        if (!equipement) {
            return res.status(404).json({ error: "Equipment not found" });
        }

        res.status(200).json(equipement);
    } catch (error) {
        console.error("Error fetching equipment by ID:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

// Delete Equipment
async function deleteEquipement(req, res) {
    try {
        const equipementId = parseInt(req.params.id);
        const equipement = await equipementService.deleteEquipment(
            equipementId
        );

        if (!equipement) {
            return res.status(404).json({ error: "Equipment not found" });
        }

        res.status(200).json({ message: "Equipment deleted successfully" });
    } catch (error) {
        console.error("Error deleting equipment:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

// Update Equipment
async function updateEquipement(req, res) {
    try {
        const equipementId = parseInt(req.params.id);
        const equipement = await equipementService.updateEquipment(
            equipementId,
            req.body
        );

        if (!equipement) {
            return res.status(404).json({ error: "Equipment not found" });
        }

        res.status(200).json(equipement);
    } catch (error) {
        console.error("Error updating equipment:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

module.exports = {
    createEquipement,
    getEquipements,
    getEquipementById,
    deleteEquipement,
    updateEquipement,
};
