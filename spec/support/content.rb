def htmlContent(name)
  fpath = Pathname.new(__dir__).join('contents', name)
  File.open(fpath).readlines.join("\n")
end
