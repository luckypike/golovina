import { FC } from "react";
import { useTranslations } from "next-intl";
import Head from "next/head";
import { useRouter } from "next/router";
import { PrivacyPolicyRu } from "./ru";
import { PrivacyPolicyEn } from "./en";

export const PrivacyPolicy: FC = () => {
  const t = useTranslations('PrivacyPolicy');
  const router = useRouter()

  return (
    <>
      <Head>
        <title>{t('title')}</title>
      </Head>

      {router.locale === 'ru' && <PrivacyPolicyRu />}
      {router.locale === 'en' && <PrivacyPolicyEn />}
    </>
  )
}
