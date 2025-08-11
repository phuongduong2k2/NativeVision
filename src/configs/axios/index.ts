import axios, { AxiosInstance, AxiosRequestConfig } from 'axios';

type TAxiosParams = Omit<AxiosRequestConfig, 'method'>;

class AxiosService {
  private instance: AxiosInstance;

  constructor() {
    this.instance = axios.create({
      baseURL: '',
      timeout: 2000,
    });

    this.instance.interceptors.request.use(
      config => {
        config.headers.Authorization = 'Access Token';
        return config;
      },
      error => {
        return Promise.reject(error);
      },
    );

    this.instance.interceptors.response.use(
      config => {
        return config;
      },
      error => {
        return Promise.reject(error);
      },
    );
  }

  async get(params: TAxiosParams) {
    try {
      const config: AxiosRequestConfig = {
        ...params,
      };
      return await this.instance.get('', config);
    } catch (error) {
      return error;
    }
  }
}

export const httpService = new AxiosService();
