FROM vikashkothary/ruby:2.6-alpine3.9

ENV SMTP_ENABLE true \
	SMTP_ADDRESS "localhost" \
	STMP_PORT 25 \
	SMTP_USER_NAME "admin" \
	SMTP_PASSWORD "admin" \
	SMTP_DOMAIN "localhost" \
	SMTP_AUTHENTICATION "login" \
	SMTP_ENABLE_STARTTLS_AUTO true \ SMTP_OPENSSL_VERIFY_MODE "peer" \ GITLAB_EMAIL_FROM gitlab@domain.com \ GITLAB_EMAIL_REPLY_TO noreply@domain.com

RUN apk --no-cache add git

RUN mkdir -p /home && \
	git clone https://gitlab.com/gitlab-org/gitlab-ce.git -b v11.10.4 gitlab
WORKDIR /home/gitlab

RUN addgroup -S git && adduser -S -g git gitlab
USER gitlab

RUN cp config/gitlab.yml.example config/gitlab.yml && \
	sudo chown -R git {log,tmp} && \
	sudo chmod -R u+rwX {log,tmp,tmp/pids,tmp/sockets,public/uploads} && \
	sudo -u git -H mkdir /home/git/gitlab-satellites && \
	sudo chmod u+rwx,g+rx,o-rwx /home/git/gitlab-satellites && \
	sudo -u git -H cp config/unicorn.rb.example config/unicorn.rb && \
	sudo -u git -H cp config/initializers/rack_attack.rb.example config/initializers/rack_attack.rb && \
	sudo -u git cp config/database.yml.postgresql config/database.yml && \
	chmod o-rwx config/database.yml
RUN gem install bundler && \
	bundle install --deployment --without development test mysql aws

