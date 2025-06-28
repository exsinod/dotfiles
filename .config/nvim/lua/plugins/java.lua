return {
  {
    "mfussenegger/nvim-jdtls",
    opts = {
      settings = {
        java = {
          format = {
            enabled = true,
            settings = {
              url = "https://raw.githubusercontent.com/diffplug/spotless/2d32ccd3ef17e80f456f7bd3587846f2734bca71/gradle/spotless.eclipseformat.xml",
              profile = "Spotless",
            },
          },
        },
      },
    },
  },
}
