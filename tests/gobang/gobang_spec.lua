local plugin = require("gobang")

describe("setup", function()
  it("works with default", function()
    assert(plugin.gobang() == "Hello!", "my first function with param = Hello!")
  end)

  it("works with custom var", function()
    plugin.setup({ opt = "custom" })
    assert(plugin.gobang() == "custom", "my first function with param = custom")
  end)
end)
