import { Sequelize } from "sequelize";

import configData from "./config.json" with { type: "json" };

const mode = process.env.NODE_ENV || "development";
const config = configData[mode];

const sequelize = new Sequelize({
    storage: config.storage,
    dialect: config.dialect,
});

export default sequelize;