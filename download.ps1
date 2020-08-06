$links = @()
$links += "https://files.pythonhosted.org/packages/16/89/f2d29c2eafc2eeafb17d5634340e06366af904d332341200a49d954bce85/tensorflow-2.3.0-cp37-cp37m-manylinux2010_x86_64.whl#sha256=92430b6e91f00f38a602c4f547bbbaca598a3a90376f90d5b2acd24bc18fa1d7"
$links += "https://files.pythonhosted.org/packages/8c/5d/faf0d8ac260c7f1eda7d063001c137da5223be1c137658384d2d45dcd0d5/torch-1.6.0-cp38-cp38-manylinux1_x86_64.whl#sha256=5357873e243bcfa804c32dc341f564e9a4c12addfc9baae4ee857fcc09a0a216"
$links += "https://files.pythonhosted.org/packages/38/53/914885a93a44b96c0dd1c36f36ff10afe341f091230aad68f7228d61db1e/torch-1.6.0-cp36-cp36m-manylinux1_x86_64.whl#sha256=7669f4d923b5758e28b521ea749c795ed67ff24b45ba20296bc8cff706d08df8"
$links += "https://files.pythonhosted.org/packages/fb/59/1446c28d5dec00609ab664217acdbd37cf93704ae37233c1392465fc49e5/tensorflow-2.3.0-cp38-cp38-macosx_10_11_x86_64.whl#sha256=44c8d979b2d19ed56dbe6b03aef87616d6138a58fd80c43e7a758c90105e9adf"
$links += "https://files.pythonhosted.org/packages/97/ae/0b08f53498417914f2274cc3b5576d2b83179b0cbb209457d0fde0152174/tensorflow-2.3.0-cp36-cp36m-manylinux2010_x86_64.whl#sha256=5c9f9a36d5b4d0ceb67b985486fe4cc6999a96e2bf89f3ba82ffd8317e5efadd"
$links += "https://files.pythonhosted.org/packages/06/45/7578e531889bdd03353ba2a0a0537cf894fbfb8d4cb3b72943b1da9b2533/tensorflow-2.3.0-cp36-cp36m-macosx_10_11_x86_64.whl#sha256=b1699903cf3a9f41c379d79ada2279a206a071b7e05671646d7b5e7fc37e2eae"
$links += "https://files.pythonhosted.org/packages/e5/96/0c370ed7fc96e281aa4e93356cba8663d4295c8aad685d67ed1991aeaaff/tensorflow-2.3.0-cp37-cp37m-macosx_10_11_x86_64.whl#sha256=0cfb0fbe875408cdbfc7677f12aa0b23656f3e6d8c5f568b3100450ec29262a7"

foreach ($link in $links) {
    wget -O test.whl --tries=1 --quiet $link
    $sha = ((& sha256sum test.whl) -Split (" "))[0]
    Write-Host "sha: $sha"
    if ($link -match $sha) {
        Remove-Item test.whl
        continue
    } else {
        Write-Host "Error! got sha $sha, but it is not sha from link $($link.Split('sha256=')[1])"
        exit 1
    }
}