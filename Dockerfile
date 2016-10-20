FROM ubuntu:16.04
ADD http://gettaurus.org/snapshots/blazemeter-pbench-extras_0.1.10.1_amd64.deb /tmp
ADD http://chromedriver.storage.googleapis.com/2.24/chromedriver_linux64.zip /tmp
ADD https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux64.tar.gz /tmp
RUN apt-get -y update \
  && apt-get -y install --no-install-recommends software-properties-common \
  && apt-add-repository multiverse \
  && add-apt-repository ppa:yandex-load/main \
  && apt-add-repository ppa:nilarimogard/webupd8 \
  && apt-get -y update \
  && apt-cache policy firefox \
  && apt-get -y install --no-install-recommends \
    kmod \
    unzip \
    build-essential \
    libxslt1-dev \
    zlib1g-dev \
    libxi6 \
    libgconf-2-4 \
    libexif12 \
    udev \
    python-dev \
    python-pip \
    default-jdk \
    xvfb \
    libyaml-dev \
    siege \
    tsung \
    phantom \
    phantom-ssl \
    firefox \
    chromium-browser \
    pepperflashplugin-nonfree \
    flashplugin-installer \
    phantomjs \
    ruby ruby-dev \
    nodejs \
    npm \
  && pip install --upgrade setuptools pip \
  && pip install locustio bzt && pip uninstall -y bzt \
  && pip install --upgrade selenium \
  && npm install -g mocha \
  && gem install rspec \
  && gem install selenium-webdriver \
  && dpkg -i /tmp/blazemeter-pbench-extras_0.1.10.1_amd64.deb \
  && unzip -d /usr/bin /tmp/chromedriver_linux64.zip \
  && tar -xzf /tmp/geckodriver-v0.11.1-linux64.tar.gz --directory /usr/local/bin \
  && rm -rf /var/lib/apt/lists/* \
  && firefox --version && chromium-browser --version && /usr/bin/chromedriver --version && geckodriver --version

VOLUME ${LINUX_PATH}
