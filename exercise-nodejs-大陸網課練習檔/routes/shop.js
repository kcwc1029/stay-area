const express = require("express");
const path = require("path");
const productController = require("../controllers/product");

const router = express.Router();
// 首頁
router.get("/", productController.getIndex);
// 商品列表
router.get("/product-list", productController.getProductList);
// 購物車
router.get("/cart", productController.getCart);
// 訂單管理
router.get("/checkout", productController.getCheckout);
// 物品添加
router.get("/add-product", productController.getAddProduct);
router.post("/add-product", productController.postAddProduct);
// 所有產品管理
router.get("/products", productController.getProducts);
module.exports = router;
