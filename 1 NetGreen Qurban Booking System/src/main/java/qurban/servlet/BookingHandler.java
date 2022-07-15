package qurban.servlet;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import qurban.dao.*;
import qurban.javabean.*;

@WebServlet("/BookingHandler")
public class BookingHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
     BookingDAO bookingDAO;
     AnimalOrderDAO animalOrderDAO;

    public BookingHandler() {
        super();
        bookingDAO = new BookingDAO();
        animalOrderDAO = new AnimalOrderDAO();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Set content type
		response.setContentType("text/html");
		
		// Get action
		String action = request.getParameter("action");
				
		// Filter action
		try {
			switch(action) {
			case "createBooking":
				createBooking(request, response); 
				break;
				
			case "toPayment":
				toPayment(request, response);
				break;
				
			case "toBooking":
				toBooking(request, response);
				break;
				
			case "toBookingList":
				toBookingList(request, response);
				break;
				
			case "toInvoice":
				toInvoice(request, response);
				break;	
			
			case "cancelBooking":
				cancelBooking(request, response);
				break;
			}
					
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// CRUD -------------------------------------------
	private void createBooking(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int clientID = Integer.parseInt(request.getParameter("clientID"));
		Date bookingDate = Date.valueOf(request.getParameter("bookingDate"));
		
		// Create New Booking object
		Booking newBooking = new Booking();
		
		newBooking.setBookingDate(bookingDate);
		newBooking.setClientID(clientID);
		
		// Send to DAO and retrieve bookingID
		int bookingID = bookingDAO.createBooking(newBooking);
		
		// Go to Booking Page
		request.setAttribute("bookingID", bookingID);
		
		RequestDispatcher toBooking = request.getRequestDispatcher("new-booking.jsp");
		toBooking.forward(request, response);
				
		
	}
	
	// ADDITIONAL METHODS ----------------------------------------------------------------------
	
	private void toPayment(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
		
		// Get and set attributes
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		double paymentTotal = Double.parseDouble(request.getParameter("paymentTotal"));
		
		request.setAttribute("bookingID", bookingID);
		request.setAttribute("paymentTotal", paymentTotal);
		
		// To payment page
		RequestDispatcher toPaymentPage = request.getRequestDispatcher("new-payment.jsp");
		toPaymentPage.forward(request, response);
	
	
	}
	
	private void toInvoice(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
		
		// Get and set attributes
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		double paymentTotal = Double.parseDouble(request.getParameter("paymentTotal"));
		
		request.setAttribute("bookingID", bookingID);
		request.setAttribute("paymentTotal", paymentTotal);
		
		// To payment page
		RequestDispatcher toInvoicePage = request.getRequestDispatcher("invoice.jsp");
		toInvoicePage.forward(request, response);
	
	
	}
	
	private void toBooking(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
		
		// Get and set attributes
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		double paymentTotal = Double.parseDouble(request.getParameter("paymentTotal"));
		
		request.setAttribute("bookingID", bookingID);
		request.setAttribute("paymentTotal", paymentTotal);
		
		// To booking page
		RequestDispatcher toBookingPage = request.getRequestDispatcher("new-booking.jsp");
		toBookingPage.forward(request, response);
	
	
	}
	
	private void toBookingList(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {

		// To list page
		RequestDispatcher toListPage = request.getRequestDispatcher("client-booking-list.jsp");
		toListPage.forward(request, response);
	
	
	}
	
	private void cancelBooking(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, SQLException, IOException {
		
		// Get attributes
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		String getPath = request.getParameter("path");
		
		// Send to DAO
		animalOrderDAO.deleteAnimalOrderByBooking(bookingID);
		bookingDAO.deleteBooking(bookingID);
		
		// To 
		RequestDispatcher dispatcher = null;
		
		if (getPath.equals("home")) 
			dispatcher = request.getRequestDispatcher("client-homepage.jsp");
		else if (getPath.equals("profil"))
			dispatcher = request.getRequestDispatcher("client-profile.jsp");
			
			
			
		dispatcher.forward(request, response);
	
	}


}
