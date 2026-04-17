set shell := ["bash", "-c"]

bundle-install:
    bundle install
serve:
    bundle exec jekyll serve
new-post:
    read -p "Article Name:" name ; touch "_posts/$(date +%Y-%m-%d)-${name//[[:space:]]/-}.md"
