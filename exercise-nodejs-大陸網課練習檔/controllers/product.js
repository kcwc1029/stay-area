// TODO: 引入model
const Product = require("../model/model");

// NOTE: 處理product-list
// 裡面的fetchAll是async，所以整個函數也都要使用async
exports.getIndex = async (req, res, next) => {
    try {
        const products = await Product.fetchAll(); // 等待异步操作完成
        res.render("./index", {
            prods: products,
            docTitle: "首頁",
            activeShop: true,
            breadcrumb: [
                { name: "首页", url: "/", hasBreadcrumbUrl: true },
                { name: "首页", hasBreadcrumbUrl: false },
            ],
        });
    } catch (err) {
        // 处理错误
        console.error(err);
        next(err);
    }
};

// NOTE: 處理product-list
// 裡面的fetchAll是async，所以整個函數也都要使用async
exports.getProductList = async (req, res, next) => {
    try {
        const products = await Product.fetchAll(); // 等待异步操作完成
        res.render("./product-list", {
            prods: products,
            docTitle: "商品列表",
            activeProductList: true,
            breadcrumb: [
                { name: "首页", url: "/", hasBreadcrumbUrl: true },
                { name: "商品列表", hasBreadcrumbUrl: false },
            ],
        });
    } catch (err) {
        // 处理错误
        console.error(err);
        next(err);
    }
};

// NOTE: 處理cart
exports.getCart = async (req, res, next) => {
    try {
        const products = await Product.fetchAll(); // 等待异步操作完成
        res.render("./cart", {
            prods: products,
            docTitle: "購物車",
            activeShop: true,
            breadcrumb: [
                { name: "首页", url: "/", hasBreadcrumbUrl: true },
                { name: "購物車", hasBreadcrumbUrl: false },
            ],
        });
    } catch (err) {
        // 处理错误
        console.error(err);
        next(err);
    }
};

// NOTE: 處理checkout
exports.getCheckout = async (req, res, next) => {
    try {
        const products = await Product.fetchAll(); // 等待异步操作完成
        res.render("./checkout", {
            prods: products,
            docTitle: "訂單管理",
            activeShop: true,
            breadcrumb: [
                { name: "首页", url: "/", hasBreadcrumbUrl: true },
                { name: "訂單管理", hasBreadcrumbUrl: false },
            ],
        });
    } catch (err) {
        // 处理错误
        console.error(err);
        next(err);
    }
};

// NOTE: 處理add-product;
exports.getAddProduct = (req, res, next) => {
    res.render("./add-product", {
        docTitle: "添加产品",
        path: "/add-product",
        activeAddProduct: true,
        breadcrumb: [
            { name: "首页", url: "/", hasBreadcrumbUrl: true },
            { name: "添加产品", hasBreadcrumbUrl: false },
        ],
    });
};
// NOTE: 表單 資料送進model
exports.postAddProduct = (req, res, next) => {
    // console.log(req.body);
    const title = req.body.title;
    const price = req.body.prices;
    const description = req.body.description;
    const imageURL = req.body.imageURL;
    const product = new Product(title, price, description, imageURL);
    product.save();
    res.redirect("/");
};

// NOTE: 處理getProducts
exports.getProducts = async (req, res, next) => {
    try {
        const products = await Product.fetchAll(); // 等待异步操作完成
        res.render("./products", {
            prods: products,
            docTitle: "總產品管理",
            activeProductManage: true,
            breadcrumb: [
                { name: "首页", url: "/", hasBreadcrumbUrl: true },
                { name: "總產品管理", hasBreadcrumbUrl: false },
            ],
        });
    } catch (err) {
        // 处理错误
        console.error(err);
        next(err);
    }
};
