class CypherShell < Formula
  desc "Command-line shell where you can execute Cypher against Neo4j"
  homepage "https://github.com/neo4j/cypher-shell"
  url "https://github.com/neo4j/cypher-shell/releases/download/4.1.2/cypher-shell.zip"
  sha256 "0632405d61eeaa32d63301e3ebb537f2c31197615caebc01df15082862d5b548"
  license "GPL-3.0"
  version_scheme 1

  bottle :unneeded

  depends_on java: "1.8"

  def install
    rm_f Dir["bin/*.bat"]

    # Needs the jar, but cannot go in bin
    share.install ["cypher-shell.jar"]

    # Copy the bin
    bin.install ["cypher-shell"]
    bin.env_script_all_files(share, NEO4J_HOME: ENV["NEO4J_HOME"])
  end

  test do
    # The connection will fail and print the name of the host
    assert_match /doesntexist/, shell_output("#{bin}/cypher-shell -a bolt://doesntexist 2>&1", 1)
  end
end
