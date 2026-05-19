import { DataTypes } from "sequelize";

import sequelize from "../config/db.js";

const Contact = sequelize.define(
    "contact",
    {
        phone: {
            type: DataTypes.TEXT,
            allowNull: false,
        }
    },
    {
        timestamps: false,
    }
);

export default Contact;