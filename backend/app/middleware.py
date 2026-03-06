from django.shortcuts import redirect


class StaffOnlyAPIMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        if request.path.startswith('/api/') and not getattr(request.user, 'is_staff', False):
            return redirect('/')
        
        response = self.get_response(request)
        return response
