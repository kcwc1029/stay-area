// const products = []

const path = require("path")
const fs = require("fs")
const rootDir = path.dirname(process.mainModule.filename)
const dirPath = path.join(rootDir, "data")
const filePath = path.join(dirPath, "product.json")
module.exports = class Product {
	constructor(t) {
		this.title = t
	}

	save() {
		products.push(this)
	}

	static fetchAll() {
		return products
	}
}
