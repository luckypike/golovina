class CertMailerPreview < ActionMailer::Preview
  def payed
    CertMailer.with(cert: Cert.last).payed
  end
end
