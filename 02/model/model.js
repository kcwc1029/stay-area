// const products = [];
const path = require("path");
const fs = require("fs");
const rootDir = path.dirname(process.mainModule.filename);
const dirPath = path.join(rootDir, "data");
const filePath = path.join(dirPath, "data.json");
const { v4: uuidv4 } = require("uuid");
module.exports = class Product {
    constructor(title, imageURL, price, description) {
        this.title = title;
        this.imageURL = imageURL;
        this.price = price;
        this.description = description;
    }

    save() {
        this.id = uuidv4();
        // 确认 JSON 文件是否存在
        this.constructor.checkFile().then(async (result) => {
            if (result) {
                let products = [];

                // 读取数据
                try {
                    const data = await fs.promises.readFile(filePath);
                    products = JSON.parse(data);
                } catch (err) {
                    console.log("readFile error");
                }
                console.log("step1");
                console.log(products);
                // 以创建文件，加入新元素
                products.push(this);
                console.log("step2");
                console.log(products);

                // 写数据
                try {
                    await fs.promises.writeFile(
                        filePath,
                        JSON.stringify(products)
                    );
                } catch (err) {
                    console.log("writeFile error");
                }
            }
        });
    }

    // TODO: 確認存放位置是否存在，返回promise，若以創建文件返回true
    static checkFile = async () => {
        return new Promise(async (resolve, reject) => {
            try {
                // 检查文件夹是否存在
                const dirExists = await fs.promises
                    .access(dirPath, fs.constants.F_OK)
                    .then(() => true)
                    .catch(() => false);

                if (dirExists) {
                    resolve(true);
                } else {
                    await fs.promises.mkdir(dirPath); // 创建文件夹
                    await fs.promises.writeFile(filePath, "[]"); // 创建文件并写入空数组
                    resolve(true);
                }
            } catch (err) {
                reject(err);
            }
        });
    };

    // TODO: 資料拿給前端，返回讀去後的資料，或一個空陣列
    static async fetchAll() {
        try {
            await this.checkFile(); // 确保文件存在
            const data = await fs.promises.readFile(filePath); // 读取数据
            return JSON.parse(data);
        } catch (err) {
            console.log("fetch error:", err);
            return [];
        }
    }
};
