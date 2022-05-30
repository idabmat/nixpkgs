{ lib
, fetchFromGitHub
, buildPythonPackage
, pythonOlder
, filelock
, importlib-metadata
, packaging
, pyyaml
, requests
, ruamel-yaml
, tqdm
, typing-extensions
}:

buildPythonPackage rec {
  pname = "huggingface-hub";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "huggingface";
    repo = "huggingface_hub";
    rev = "refs/tags/v${version}";
    sha256 = "sha256-GUe9+Z23vt3sfpntDnToMY5vWLK6m0zRySSJgMljetg=";
  };

  nativeBuildInputs = [ packaging ];

  propagatedBuildInputs = [
    filelock
    pyyaml
    requests
    ruamel-yaml
    tqdm
    typing-extensions
  ] ++ lib.optionals (pythonOlder "3.8") [ importlib-metadata ];

  # Tests require network access.
  doCheck = false;
  pythonImportsCheck = [ "huggingface_hub" ];

   meta = with lib; {
    homepage = "https://github.com/huggingface/huggingface_hub";
    description = "Download and publish models and other files on the huggingface.co hub";
    changelog = "https://github.com/huggingface/huggingface_hub/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ ];
  };
}
