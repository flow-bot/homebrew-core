class Goreleaser < Formula
  desc "Deliver Go binaries as fast and easily as possible"
  homepage "https://goreleaser.com/"
  url "https://github.com/goreleaser/goreleaser.git",
      tag:      "v0.155.1",
      revision: "a816d969c9749c18ed6d315a4c4bd65698fe7754"
  license "MIT"
  head "https://github.com/goreleaser/goreleaser.git"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "abb7642b9bb609bca4f7331783923b6b2b92c752d659a07fd343eaf6f6eb3dc0"
    sha256 cellar: :any_skip_relocation, big_sur:       "632981ce9324cead70e9c587aeb26a45ec92f5dd25fc800e28903958c56f3a08"
    sha256 cellar: :any_skip_relocation, catalina:      "ece7b31704b18ad57f8d910cdc58af4a81a9f45546dca7d6b253ee10e8741933"
    sha256 cellar: :any_skip_relocation, mojave:        "bbb9bf8c6a989a11dbdd5bd4aaf8dc41e251ff78fea2c3832525336ca826177f"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "-ldflags",
             "-s -w -X main.version=#{version} -X main.commit=#{Utils.git_head} -X main.builtBy=homebrew",
             *std_go_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/goreleaser -v 2>&1")
    assert_match "config created", shell_output("#{bin}/goreleaser init --config=.goreleaser.yml 2>&1")
    assert_predicate testpath/".goreleaser.yml", :exist?
  end
end
