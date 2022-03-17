class Digestif < Formula
  desc "A language server for TeX and friends"
  homepage "https://github.com/astoff/digestif"
  url "https://github.com/astoff/digestif/archive/refs/tags/0.3.tar.gz"
  sha256 "b9897958a847c78ef8e6cf7c3b180679d8edc87c2ae82aa22ef78aa0f2693c7e"
  license "MIT-Modern-Variant"
  revision 1

  resource "dkjson" do
    url "http://dkolf.de/src/dkjson-lua.fsl/raw/dkjson.lua?name=6c6486a4a589ed9ae70654a2821e956650299228"
    sha256 "bdb71dbe2863e9567d5a9a926faed1cfc4c12e04741a3e9009d334df25b9748c"
  end

  def install
    bin.mkpath
    open("#{prefix}/bin/digestif", 'a') do |f|
      f << "#!/bin/sh\n"
      f << "export DIGESTIFDATA=\"#{prefix}/data\"\n"
      f << "export DIGESTIF_HOME=\"#{prefix}\"\n"
      f << "export LUA_PATH=\"#{prefix}/?.lua\"\n"
      # Change the lines below to choose a different Lua interpreter
      f << "LUA=texlua\n"
      f << "${LUA} #{prefix}/digestif/langserver.lua $@\n"
    end
    prefix.install "data"
    prefix.install "digestif"
    prefix.install "scripts"
    prefix.install "spec"

    resource("dkjson").stage { prefix.install "dkjson.lua" }
  end

  test do
  end
end
