const express = require("express")
const router = express.Router()
const fs = require("fs")
const path = require("path")

router.put("/artifacts/key", function(req, res) {
  var contentLength = req.header("Content-Length")
  var read = 0
  var position = 0
  var data = req.body

  var keyCount = data.readInt32BE(position)
  read += 4
  position += 4
  var keys = []

  for (var k = 0; k < keyCount; k++) {
    var keyLen = data.readUInt16BE(position)
    read += 2
    position += 2
    var keyBytes = data.slice(position,position+keyLen)
    var key = keyBytes.toString("utf8")
    keys.push(key)
    position += keyLen
  }

  var cacheData = data.slice(position, position+contentLength-read)
  for (var m = 0; m < keys.length; m++) {
    var fileName = path.join(__dirname, "..", "buck-cache", keys[m]+".buckcache")
    var stream = fs.createWriteStream(fileName)
    stream.on('error', console.error)
    stream.write(cacheData)
    stream.end()
  }
  res
    .status(202)
    .set({
      'Content-Type': 'application/octet-stream',
    })
    .send("Done")
})

router.get("/artifacts/key/:key", (req, res) => {
  var key = req.params.key
  var fileName = path.join(__dirname, "..", "buck-cache", key+".buckcache")
  fs.access(fileName, (err) => {
    if (err) {
      res.status(404)
        .send("The cache does not exist")
    } else {
      fs.readFile(fileName, (err, data) => {
        res.status(200)
          .set({
            'Content-Type': 'application/octet-stream',
          })
          .send(data)
      })
    }
  })
})

module.exports = router
