/*	editAnimalOrder, viewAnimalOrderCommittee, viewbyclient
 *  booking kene wujud dulu
 */

package qurban.servlet;

import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import qurban.dao.*;
import qurban.javabean.*;


@WebServlet("/AnimalOrderHandler")
public class AnimalOrderHandler extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AnimalOrderDAO animalOrderDAO;
	HttpSession session;
       

    public AnimalOrderHandler() {
        super();
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
			case "addAnimalOrder":
				addAnimalOrder(request, response); 
				break;
						
			case "updateAnimalOrder":
				updateAnimalOrder(request, response);
				break;
						
			case "deleteAnimalOrderByBooking":
				deleteAnimalOrderByBooking(request, response);
				break;
				
			case "deleteAnimalOrder":
				deleteAnimalOrder(request, response);
				break;
						
			case "cancelUpdate":
				cancelUpdate(request, response);
				break;
					
			}
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	// CRUD METHODS -------------------------------------------------------------------------
	
	// Create/Add New Animal Order - Insert Multiple Values
	private void addAnimalOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		String animalPartType = request.getParameter("animalPartType");		// Jenis haiwan untuk 1 bahagian
		String dependentName = request.getParameter("dependentName");		// Nama yg dikorbankan
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		int animalDetailsID = Integer.parseInt(request.getParameter("animalDetailsID"));
		
		// Create New Animal Order Object
		AnimalOrder newAnimalOrder = new AnimalOrder();
			
		newAnimalOrder.setAnimalPartType(animalPartType);
		newAnimalOrder.setDependentName(dependentName);
		newAnimalOrder.setBookingID(bookingID);
		newAnimalOrder.setAnimalDetailsID(animalDetailsID);
		
		// Send to DAO
		animalOrderDAO.addAnimalOrder(newAnimalOrder);
		
		// Redirect to Booking Servlet to add booking
		request.setAttribute("bookingID", bookingID);
		RequestDispatcher toBooking = request.getRequestDispatcher("new-booking.jsp");
		toBooking.forward(request, response);
		
	}
	
	// Update Animal Order
	private void updateAnimalOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, SQLException, IOException {
		
		// Get values
		String dependentName = request.getParameter("dependentName");
		int animalOrderID = Integer.parseInt(request.getParameter("animalOrderID"));
		
		// Create Animal Order
		AnimalOrder existingAnimalOrder = new AnimalOrder();
		
		existingAnimalOrder.setDependentName(dependentName);
		existingAnimalOrder.setAnimalOrderID(animalOrderID);
		
		// Send to DAO
		animalOrderDAO.updateAnimalOrder(existingAnimalOrder);
		
		// Redirect to page
		response.sendRedirect("");
		
	}
	
	// Delete Animal Order By Booking
	private void deleteAnimalOrderByBooking(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		// Send to DAO
		animalOrderDAO.deleteAnimalOrderByBooking(bookingID);
		
		// Redirect back to page
		response.sendRedirect("");
		
	}
	
	// Delete Animal Order (1 by 1)
	private void deleteAnimalOrder(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, SQLException, IOException {
		
		// Get values from JSP
		int animalOrderID = Integer.parseInt(request.getParameter("animalOrderID"));
		int bookingID = Integer.parseInt(request.getParameter("bookingID"));
		
		// Send to DAO
		animalOrderDAO.deleteAnimalOrder(animalOrderID);
		
		// Redirect back to booking
		request.setAttribute("bookingID", bookingID);
		
		RequestDispatcher toBookingPage = request.getRequestDispatcher("new-booking.jsp");
		toBookingPage.forward(request, response);
		
	}
	
	// Cancel Update Animal Order by Client
	private void cancelUpdate(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, SQLException, IOException {
		response.sendRedirect("");
	}
	

}
