#!/bin/bash

# GitHub Pages Deployment Setup Script
# Run this from the docs directory

echo "🚀 Setting up Hugo site for GitHub Pages deployment"
echo ""

# Prompt for GitHub username
read -p "Enter your GitHub username: " username

if [ -z "$username" ]; then
    echo "❌ Username is required"
    exit 1
fi

echo ""
echo "📝 Configuration:"
echo "Repository: https://github.com/$username/$username.github.io"
echo "Site URL: https://$username.github.io/"
echo ""

# Update baseURL in hugo.toml
sed -i "s|baseURL = 'https://.*'|baseURL = 'https://$username.github.io/'|" hugo.toml
echo "✅ Updated hugo.toml with baseURL"

# Initialize git if not already initialized
if [ ! -d .git ]; then
    echo "📦 Initializing git repository..."
    git init
    echo "✅ Git repository initialized"
fi

# Check if theme is a git repo
if [ -d "themes/hugo-book/.git" ]; then
    echo "⚠️  Theme is already a git repository"
    echo "Converting to submodule..."
    rm -rf themes/hugo-book
    git submodule add https://github.com/alex-shpak/hugo-book.git themes/hugo-book
    echo "✅ Theme added as submodule"
else
    # Add as submodule
    if [ ! -f "themes/hugo-book/.git" ]; then
        git submodule add https://github.com/alex-shpak/hugo-book.git themes/hugo-book
        echo "✅ Theme added as submodule"
    fi
fi

# Update submodules
git submodule update --init --recursive

# Add all files
git add .

# Initial commit
git commit -m "Initial commit - Hugo documentation site for GitHub Pages"
echo "✅ Initial commit created"

# Add remote
git remote remove origin 2>/dev/null
git remote add origin "https://github.com/$username/$username.github.io.git"
echo "✅ Remote added"

# Set main branch
git branch -M main

echo ""
echo "✅ Setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Create repository on GitHub: https://github.com/new"
echo "   Repository name: $username.github.io"
echo "   ⚠️  Make it PUBLIC (GitHub Pages requires public repos for free accounts)"
echo ""
echo "2. Push to GitHub:"
echo "   git push -u origin main"
echo ""
echo "3. Enable GitHub Pages:"
echo "   - Go to: https://github.com/$username/$username.github.io/settings/pages"
echo "   - Under 'Source', select: GitHub Actions"
echo ""
echo "4. Your site will be available at: https://$username.github.io/"
echo ""
