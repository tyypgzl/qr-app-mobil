class ApiConstants {
  static ApiConstants? _instance;

  static ApiConstants get instance => _instance ??= ApiConstants._init();

  ApiConstants._init();

  String appId = '7CB37FAC-DAD4-3746-FFDF-F0186C7FE000';
  String androidAPIkey = '20F27A9B-327E-45A4-9F92-771CD0241D67';
  String jsAPIkey = 'E6BF3601-CF19-4FA2-8007-4E796102867E';
  String restAPIkey = '4D3E3861-7CDA-49B4-BB1C-BDC818DD65C9';
  String url = 'stoicaltomato.backendless.app';

  String supabaseURL = 'https://lbogfvutuiklzanebhmk.supabase.co';
  String supabaseKEY =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxib2dmdnV0dWlrbHphbmViaG1rIiwicm9sZSI6ImFub24iLCJpYXQiOjE2NTE4MjEyODYsImV4cCI6MTk2NzM5NzI4Nn0.ExN0vre4bXxfCGAi9dOoOfwAmxHl3n80G3dmr5zeztE';
}
