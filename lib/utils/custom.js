this.json = function json() {
  var args = Array.prototype.slice.call(arguments)
  var str = args.shift()
  if (typeof str === 'string') {
    str = JSON.parse(str)
  }
  args.unshift(str)
  return JSON.stringify.apply(JSON, args)
}

this.showJson = function showJson() {
  var args = Array.prototype.slice.call(arguments)
  if (args.length < 1) {
    return
  }
  if (args.length === 1) {
    args.push(null)
  }
  if (args.length === 2) {
    args.push(4)
  }
  console.log(this.json.apply(this, args))
}