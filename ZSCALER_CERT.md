# ZScaler Certifacte on Windows 11 WSL

When encountering Zscaler certificate issues within Windows Subsystem for Linux (WSL) on Windows 11, the problem usually stems from WSL not trusting the Zscaler root certificate that is trusted by the Windows host.

To address this, you need to ensure the Zscaler root certificate is properly installed and trusted within your WSL distribution. Here's a common approach:
Export the Zscaler Root Certificate from Windows:

- Open the Certificate Manager in Windows by searching for certmgr.msc.
Navigate to "Trusted Root Certification Authorities" -> "Certificates".

- Locate the Zscaler root certificate (e.g., "Zscaler Root CA").
Right-click the certificate, select "All Tasks" -> "Export...".

- Follow the Certificate Export Wizard, choosing "Base-64 encoded X.509 (.CER)" format. Save the certificate to a location accessible by WSL (e.g., your Windows Downloads folder, which will be mounted within WSL).

- Import the Certificate into WSL:

- Open your WSL distribution.

- Navigate to the directory where you saved the exported certificate (e.g., /mnt/c/Users/YourUsername/Downloads/).

- Copy the certificate to the /usr/local/share/ca-certificates/ directory in your WSL distribution:

  ```shell
  sudo cp ZscalerRootCA.cer /usr/local/share/ca-certificates/ZscalerRootCA.crt
  ```

- Replace ZscalerRootCA.cer with the actual filename of your exported certificate. Update the certificate authority list.

  ```shell
  sudo update-ca-certificates
  ```

