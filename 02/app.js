const express = require("express")
const bodyParser = require("body-parser")
const adminRoutes = require("./routes/route")
// const shopRoutes = require("./routes/shop")
const path = require("path")
const rootDir = path.dirname(process.mainModule.filename)
const app = express()

app.set("view engine", "ejs")
app.set("views", "views")

app.use(bodyParser.urlencoded({ extended: false }))
app.use(express.static(path.join(__dirname, "public")))

// app.use(shopRoutes)
app.use("/admin", adminRoutes)

// NOTE: 錯誤處理
app.use((req, res, next) => {
	res.status(404).render("404", { docTitle: "页面未找到" })
})

app.listen(3000)
