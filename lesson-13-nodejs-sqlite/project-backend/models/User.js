import { DataTypes } from "sequelize";

import sequelize from "../config/db.js";

const User = sequelize.define(
    "user",
    {
        name: {
            type: DataTypes.TEXT,
            allowNull: false,
        }
    }
);
User.sync();
export default User;