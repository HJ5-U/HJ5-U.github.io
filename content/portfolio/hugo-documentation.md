---
title: "Hugo Documentation Site"
weight: 2
---

# Hugo Documentation Site

**Project Type:** Static Site Generator  
**Date:** November 7, 2025  
**Repository:** [HJ5-U.github.io](https://github.com/HJ5-U/HJ5-U.github.io)  
**Live Site:** [https://hj5-u.github.io/](https://hj5-u.github.io/)

## Overview

A professional documentation website built with Hugo and the hugo-book theme, deployed to GitHub Pages with automated CI/CD using GitHub Actions.

## Key Features

✅ **Hugo Static Site Generator** - Fast, modern documentation framework  
✅ **Hugo Book Theme** - Clean, professional documentation theme  
✅ **GitHub Pages Hosting** - Free, reliable hosting  
✅ **Automated Deployment** - GitHub Actions workflow  
✅ **Responsive Design** - Mobile-friendly documentation  
✅ **Search Functionality** - Built-in content search

## Technical Implementation

### Site Structure
```
docs/
├── hugo.toml              # Configuration
├── content/
│   ├── _index.md         # Homepage
│   ├── docs/             # Documentation pages
│   └── portfolio/        # Portfolio section
├── static/
│   └── images/           # Static assets
├── themes/
│   └── hugo-book/        # Theme (git submodule)
└── .github/
    └── workflows/
        └── hugo.yml      # GitHub Actions
```

### Configuration Highlights

**hugo.toml:**
- Base URL: `https://HJ5-U.github.io/`
- Theme: hugo-book
- Table of Contents enabled
- Search functionality enabled
- Markdown rendering with HTML support

### Deployment Pipeline

**GitHub Actions Workflow:**
1. Triggered on push to `main` branch
2. Checks out repository code
3. Sets up Hugo environment
4. Builds static site
5. Deploys to GitHub Pages
6. Site live in ~30 seconds

## Implementation Process

### 1. Installation
```bash
sudo snap install hugo
hugo new site docs
```

### 2. Theme Setup
```bash
cd docs
git init
git submodule add https://github.com/alex-shpak/hugo-book themes/hugo-book
```

### 3. Configuration
Created `hugo.toml` with:
- Site metadata (title, baseURL)
- Theme configuration
- Menu structure
- Search settings

### 4. Content Creation
- Homepage with project overview
- Documentation pages for API reference
- Portfolio section for projects
- Static images for screenshots

### 5. GitHub Actions Setup
Created `.github/workflows/hugo.yml`:
- Hugo setup with extended version
- Build process configuration
- GitHub Pages deployment
- Permissions for deployment

### 6. Repository Configuration
- Enabled GitHub Pages in repository settings
- Set source to GitHub Actions
- Configured custom domain (optional)

## Challenges & Solutions

### Challenge 1: Image Path Issues
**Problem:** Images worked locally but not on deployed site  
**Solution:** Moved images from `content/` to `static/images/` folder and updated paths to use `/images/` prefix

### Challenge 2: Nested Git Repositories
**Problem:** Hugo site inside larger project caused git conflicts  
**Solution:** Used `git rm --cached` to remove nested repo from parent project tracking

### Challenge 3: Theme Submodule
**Problem:** Hugo-book theme not deploying to GitHub Pages  
**Solution:** Added submodule checkout step to GitHub Actions workflow with `submodules: true`

## Features Implemented

### Navigation
- Left sidebar with hierarchical menu
- Breadcrumb navigation
- Table of contents for long pages
- Search bar for content discovery

### Content Organization
- **Docs Section:** API reference, deployment guides, getting started
- **Portfolio Section:** Project showcases with technical details
- **Homepage:** Quick overview with screenshots and links

### Styling
- Professional book-style theme
- Syntax highlighting for code blocks
- Responsive layout for mobile devices
- Dark/light mode support (theme default)

## Learning Outcomes

- Learned Hugo static site generator framework
- Mastered Git submodules for theme management
- Implemented GitHub Actions CI/CD pipeline
- Practiced Markdown documentation writing
- Deployed to GitHub Pages successfully
- Understood static site deployment workflows

## Performance Metrics

- **Build Time:** ~0.5 seconds
- **Page Load:** < 1 second
- **Lighthouse Score:** 95+ performance
- **Deploy Time:** ~30 seconds from push to live

## Future Enhancements

- Custom domain configuration
- Additional documentation sections
- Interactive API playground
- Code snippet copy buttons
- Version control for docs
- Comment system integration
- Analytics integration

---

**Technologies Used:** Hugo, hugo-book theme, GitHub Pages, GitHub Actions, Markdown, TOML
