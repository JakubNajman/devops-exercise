FROM yndconsult/docker-ruby:2.6.3-centos7
WORKDIR "/app"

RUN curl –sL https://rpm.nodesource.com/setup_10.x | bash -
RUN curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

RUN yum install yarn nodejs postgresql-devel bundler gettext -y
COPY yarn.lock Gemfile ./

RUN yarn upgrade @rails/webpacker
RUN bundle install

#COPY . .
COPY /. /app

# ENV DATABASE_NAME="blog_backend"
# ENV DATABASE_PASSWORD="blog_backend"
# ENV DATABASE_USERNAME="blog_backend"
# ENV DATABASE_HOST="postgresql-service.default.svc.cluster.local"

ENTRYPOINT /app/docker-entrypoint.sh