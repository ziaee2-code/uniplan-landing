// Current language
let currentLang = 'en';

// Initialize
document.addEventListener('DOMContentLoaded', function() {
    // Load saved language or detect browser language
    const savedLang = localStorage.getItem('language');
    const browserLang = navigator.language.split('-')[0];
    
    if (savedLang && translations[savedLang]) {
        changeLanguage(savedLang);
    } else if (translations[browserLang]) {
        changeLanguage(browserLang);
    } else {
        changeLanguage('en');
    }
    
    // Language selector
    const langBtn = document.getElementById('langBtn');
    const langDropdown = document.getElementById('langDropdown');
    
    langBtn.addEventListener('click', function(e) {
        e.stopPropagation();
        langDropdown.classList.toggle('active');
    });
    
    document.addEventListener('click', function() {
        langDropdown.classList.remove('active');
    });
    
    // Contact form
    const contactForm = document.getElementById('contactForm');
    if (contactForm) {
        contactForm.addEventListener('submit', handleFormSubmit);
    }
    
    // Smooth scroll
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
});

// Change language function
function changeLanguage(lang) {
    if (!translations[lang]) return;
    
    currentLang = lang;
    localStorage.setItem('language', lang);
    
    // Update document direction
    document.body.setAttribute('dir', translations[lang].dir);
    document.documentElement.setAttribute('lang', lang);
    
    // Update current language display
    const langMap = {
        'en': 'EN',
        'fa': 'FA',
        'ar': 'AR',
        'zh': 'ZH',
        'es': 'ES',
        'fr': 'FR'
    };
    document.getElementById('currentLang').textContent = langMap[lang];
    
    // Update all translated elements
    updateTranslations();
    
    // Close dropdown
    document.getElementById('langDropdown').classList.remove('active');
}

// Update translations
function updateTranslations() {
    const elements = document.querySelectorAll('[data-i18n]');
    
    elements.forEach(element => {
        const key = element.getAttribute('data-i18n');
        const translation = getNestedTranslation(translations[currentLang], key);
        
        if (translation) {
            if (element.tagName === 'INPUT' || element.tagName === 'TEXTAREA') {
                element.placeholder = translation;
            } else {
                element.textContent = translation;
            }
        }
    });
}

// Get nested translation
function getNestedTranslation(obj, path) {
    return path.split('.').reduce((current, key) => current?.[key], obj);
}

// Handle form submission
// Handle form submission
function handleFormSubmit(e) {
    e.preventDefault();

    const successAlert = document.getElementById('successAlert');
    const errorAlert = document.getElementById('errorAlert');
    const submitButton = e.target.querySelector('button[type="submit"]');
    const form = e.target;

    // Hide alerts
    successAlert.classList.remove('show');
    errorAlert.classList.remove('show');

    // Disable button
    submitButton.disabled = true;
    const originalText = submitButton.textContent;
    submitButton.textContent = originalText + '...';

    // Get form data
    const formData = new FormData(form);

    // Send to Formspree
    fetch(form.action, {
        method: 'POST',
        body: formData,
        headers: {
            'Accept': 'application/json'
        }
    })
    .then(response => {
        if (response.ok) {
            // Success
            successAlert.classList.add('show');
            form.reset();

            // Hide success message after 5 seconds
            setTimeout(() => {
                successAlert.classList.remove('show');
            }, 5000);
        } else {
            // Error
            errorAlert.classList.add('show');
            setTimeout(() => {
                errorAlert.classList.remove('show');
            }, 5000);
        }
    })
    .catch(error => {
        // Error
        errorAlert.classList.add('show');
        setTimeout(() => {
            errorAlert.classList.remove('show');
        }, 5000);
    })
    .finally(() => {
        // Re-enable button
        submitButton.disabled = false;
        submitButton.textContent = originalText;
    });
}

