const equipementTypeService = require("../services/equipementTypeServices");

//getAllEquipementTypes
async function getAllEquipementTypes(req, res) {
    try {
        const equipementTypes =
            await equipementTypeService.getAllEquipementTypes();
        res.json(equipementTypes);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

// createEquipementType
async function createEquipementType(req, res) {
    try {
        const { name, category } = req.body;

        // validate
        if (!name || !category) {
            return res
                .status(400)
                .json({ message: "Name and category are required" });
        }

        const newEquipementType =
            await equipementTypeService.createEquipementType(req.body);
        res.status(201).json(newEquipementType);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

// deleteEquipementType
async function deleteEquipementType(req, res) {
    try {
        const equipementId = req.params.id;
        const equipementType = await equipementTypeService.deleteEquipementType(
            equipementId
        );
        if (!equipementType) {
            return res.status(404).json({ error: "Equipment Type not found" });
        }

        res.status(200).json({ message: "Equipment Type deleted successfully" });


    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

module.exports = {
    getAllEquipementTypes,
    createEquipementType,
    deleteEquipementType
};
