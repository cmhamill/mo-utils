{ curl, lib, openssl, shellcheck, stdenv, swaks }:

stdenv.mkDerivation {
  pname = "mo-utils";
  version = "0.1.2";
  src = ./.;

  meta = {
    description = "Utility collection with a cheap pun";
    homepage = "https://github.com/chamill/mo-utils";
    license = lib.licenses.mit;
  };

  makeFlags = [
    "prefix=$(out)"
  ];

  postFixup = ''
    substituteInPlace $out/bin/email-exists \
      --replace swaks ${swaks}/bin/swaks
    substituteInPlace $out/bin/gravatar \
      --replace curl ${curl}/bin/curl
    substituteInPlace $out/bin/public-ip \
      --replace curl ${curl}/bin/curl
    substituteInPlace $out/bin/ssl-show-chain \
      --replace openssl ${openssl}/bin/openssl
  '';

  doCheck = true;
  checkInputs = [
    shellcheck
  ];
}
