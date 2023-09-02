// const products = [];
const Product = require("../models/product")

exports.getAddProduct = (req, res, next) => {
	res.render("add-product", {
		docTitle: "添加产品",
		path: "/admin/add-product",
		activeAddProduct: true,
		breadcrumb: [
			{ name: "首页", url: "/", hasBreadcrumbUrl: true },
			{ name: "添加产品", hasBreadcrumbUrl: false },
		],
	})
}

exports.postAddProduct = (req, res, next) => {
	// products.push({ title: req.body.title })
	const product = new Product(req.body.title)
	product.save()
	res.redirect("/")
}

exports.getProducts = (req, res, next) => {
	const products = Product.fetchAll()
	res.render("shop", {
		prods: products,
		docTitle: "商城",
		path: "/",
		hasProducts: products.length > 0,
		activeShop: true,
		breadcrumb: [
			{ name: "首页", url: "/", hasBreadcrumbUrl: true },
			{ name: "商城", hasBreadcrumbUrl: false },
		],
	})
}
