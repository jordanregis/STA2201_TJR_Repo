//
// This Stan program defines a simple model, with a
// vector of values 'y' modeled as normally distributed
// with mean 'mu' and standard deviation 'sigma'.
//
// Learn more about model development with Stan at:
//
//    http://mc-stan.org/users/interfaces/rstan.html
//    https://github.com/stan-dev/rstan/wiki/RStan-Getting-Started
//

// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> N; //num regions
  int<lower=0> y[N];  //  
  vector[N] log_e;  //  
  vector[N] x;  //  
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  vector[N] alpha;
  real beta;
  real mu_0;
  real<lower=0> sig_0;
}

transformed parameters{
  vector[N] log_theta;
  log_theta = alpha + beta * x;
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  y ~ poisson_log(log_theta + log_e);
  mu_0 ~ normal(0, 1);
  sig_0 ~ normal(0, 1);
  alpha ~ normal(mu_0, sig_0);
  beta ~ normal(0, 1);
}

