package com.skishop.config;

import io.micrometer.prometheus.PrometheusConfig;
import io.micrometer.prometheus.PrometheusMeterRegistry;
import org.springframework.boot.actuate.metrics.export.prometheus.PrometheusScrapeEndpoint;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;

@Configuration
public class MetricsConfig {

    @Bean
    @ConditionalOnMissingBean
    public PrometheusMeterRegistry prometheusMeterRegistry() {
        return new PrometheusMeterRegistry(PrometheusConfig.DEFAULT);
    }

    @Bean
    @ConditionalOnMissingBean
    public PrometheusScrapeEndpoint prometheusScrapeEndpoint(PrometheusMeterRegistry registry) {
        return new PrometheusScrapeEndpoint(registry.getPrometheusRegistry());
    }
}
