export default {
  // CUSTOMIZE THIS: Your organization's name
  // The deploy script will automatically replace "OpnForm" throughout the app with this name
  app_name: "Avalon Forms",

  locale: "en",
  locales: { en: "EN" },
  githubAuth: null,
  notion: { worker: "https://notion-forms-worker.notionforms.workers.dev/v1" },

  links: {
    // CUSTOMIZE THESE: Set to your URLs or leave empty ("") to hide
    // The deploy script automatically hides links with empty values
    // These appear in navbar/footer of dashboard and other pages (not in your custom landing/login)

    // Help/Support link (appears in navbar)
    help_url: "",  // Set to your help URL or "" to hide

    // Social/External links (appear in footer on some pages)
    github_url: "",
    github_forum_url: "",
    discord: "",
    twitter: "",

    // Integration links (for advanced features)
    zapier_integration: "",
    book_onboarding: "",

    // Feedback/Product links (appear in footer/menus)
    feature_requests: "",
    changelog_url: "",
    roadmap: "",

    // Documentation links (appear in footer/settings)
    tech_docs: "",
    api_docs: "",
  },
}
