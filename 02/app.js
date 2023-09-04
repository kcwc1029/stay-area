const express = require("express");
const bodyParser = require("body-parser");
const shopRoutes = require("./routes/shop");
const path = require("path");
const rootDir = path.dirname(process.mainModule.filename);
const app = express();

app.set("view engine", "ejs");
app.set("views", "views");

app.use(bodyParser.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

// TODO: 控制路由
app.use(shopRoutes);

// TODO: 處理錯誤
app.use((req, res, next) => {
    // res.status(404).sendFile(path.join(rootDir, 'views', '404.html'));
    res.status(404).render("404", { docTitle: "页面未找到" });
});

app.listen(3000);
