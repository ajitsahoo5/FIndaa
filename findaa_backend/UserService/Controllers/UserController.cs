using FirebaseAdmin;
using FirebaseAdmin.Messaging;
using Google.Apis.Auth.OAuth2;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using UserService.Database;
using UserService.Database.Entities;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace UserService.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        DatabaseContext db;

        public UserController()
        {
            db = new DatabaseContext();
        }

        // GET: api/<UserController>

        [HttpGet]
        public IEnumerable<User> Get()
        {
            return db.Users.ToList();
            
        }

        // GET api/<UserController>/5
        [HttpGet("{id}")]
        public User Get(int id)
        {
            return db.Users.Find(id);
        }

        [HttpGet("{mobile}/user")]
        public User GetByMobile(string mobile)
        {
            List<User> users = db.Users.ToList();
            User user = null;
            foreach (User u in users)
            {
                if (u.MobileNo.Equals(mobile))
                {
                    user = u;
                    break;
                }
            }
            return user;
        }

        // POST api/<UserController>
        [HttpPost("register")]
        public LoginResponse RegisterUser([FromBody] RegisterRequest registerRequest)
        {
            User model = registerRequest.UserData;
            string userToken = registerRequest.UserToken;
            string group = registerRequest.Group;
            try
            {
                LoginResponse response = new LoginResponse();
                List<User> users = db.Users.ToList();
                User user = null;
                foreach (User u in users)
                {
                    if (u.MobileNo.Equals(model.MobileNo))
                    {
                        user = u;
                        break;
                    }
                }
                if (user == null)
                {
                    try
                    {
                        db.Users.Add(model);
                        db.SaveChanges();
                        response.ResponseCode = "1";
                        response.ResponseMessage = "User created successfully";
                        response.UserData = model;
                        SaveUserToken(userToken,model.MobileNo,group);
                        //SendNotification(userToken);
                        SendNotificaionAlert(group, userToken);
                        return response;
                    }
                    catch (Exception ex)
                    {
                        response.ResponseCode = "0";
                        response.ResponseMessage = "Failed!\nError : "+ex.Message;
                        return response;
                    }
                }
                else
                {
                    response.ResponseCode = "0";
                    response.ResponseMessage = "User already exist!";
                    return response;
                }
            }
            catch(Exception ex)
            {
                LoginResponse response = new LoginResponse();
                response.ResponseCode = "0";
                response.ResponseMessage = ex.Message;
                return response;
            }
        }

        private void SaveUserToken(string userToken, string mobileNo, string group)
        {
            bool isDevicePresent = false;
            List<Token> userTokens = db.UserTokens.ToList();
            Token tokenData = new Token();
            if (userTokens.Count() > 0)
                foreach (Token token in userTokens)
                {
                    if (token.UserToken.Equals(userToken))
                    {
                        isDevicePresent = true;
                        break;
                    }
                }
            if (!isDevicePresent)
            {
                User model = GetByMobile(mobileNo);
                tokenData.UserToken = userToken;
                tokenData.Group = group;
                tokenData.UserId = model.UserId;
                db.UserTokens.Add(tokenData);
                db.SaveChanges();
            }
        }
        [HttpPost("login")]
        public LoginResponse UserLogin([FromBody] LoginRequest request)
        {
            LoginResponse response = new LoginResponse();
          
                List<User> users =  db.Users.ToList();
                User user = null;
                foreach(User u in users)
                {
                    if (u.MobileNo.Equals(request.Mobile))
                    {
                        user = u;
                        break;
                    }
                }
                if(user != null) { 

                if (user.Password.Equals(request.Password))
                {
                    User u = new User();
                    response.ResponseCode = "1";
                    response.ResponseMessage = "Login Successful";
                    u.FirstName = user.FirstName;
                    u.LastName = user.LastName;
                    u.City = user.City;
                    u.Locality = user.Locality;
                    u.MobileNo = user.MobileNo;
                    response.UserData = u;
                }
                else
                {
                    response.ResponseCode = "0";
                    response.ResponseMessage = "Login failed, Wrong password!";
                    response.UserData = null;
                }
            }
            else
            {
                response.ResponseCode = "0";
                response.ResponseMessage = "User not registered!";
                response.UserData = null;
            }

            return response;
        }

        // PUT api/<UserController>/5
        [HttpPut("{id}")]
        public void Put(int id, [FromBody] string value)
        {
        }

        // DELETE api/<UserController>/5
        [HttpDelete("{id}")]
        public void Delete(int id)
        {
        }

        private void SendNotification(string token)
        {
            try
            {
                FirebaseApp.Create(new AppOptions()
                {
                    Credential = GoogleCredential.FromFile("private_key.json")
                });

                var registrationToken = token;

                var message = new Message()
                {
                    Token = registrationToken,
                    Notification = new Notification()
                    {
                        Title = "Findaa",
                        Body = "Registration successful!"
                    }
                };

                string response = FirebaseMessaging.DefaultInstance.SendAsync(message).Result;

                Console.WriteLine("Successfully sent message" + response);
            }
            catch(Exception e)
            {
                Console.Write(e.Message);
                if (e.Message.Equals("The default FirebaseApp already exists."))
                {
                    var registrationToken = token;

                    var message = new Message()
                    {
                        Token = registrationToken,
                        Notification = new Notification()
                        {
                            Title = "Findaa",
                            Body = "Registration successful!"
                        }
                    };

                    string response = FirebaseMessaging.DefaultInstance.SendAsync(message).Result;

                    Console.WriteLine("Successfully sent message" + response);
                }
            }

        }
        private void SendNotificaionAlert(string group, string userToken)
        {
            List<Token> userTokens = db.UserTokens.ToList();
            List<string> tokenTosendNotification = new List<string>();
            foreach (Token token in userTokens)
            {
                if (token.Group.Equals(group) && !token.UserToken.Equals(userToken))
                {
                    tokenTosendNotification.Add(token.UserToken);
                }
            }
            try
            {
                AppOptions appOptions = new AppOptions()
                {
                    Credential = GoogleCredential.FromFile("private_key.json")
                };
                //if (FirebaseApp.ReferenceEquals)
                FirebaseApp.Create(appOptions);

                foreach (String registrationToken in tokenTosendNotification)
                {
                    var message = new Message()
                    {
                        Token = registrationToken,
                        Notification = new Notification()
                        {
                            Title = "Findaa",
                            Body = "New User registered for " + group
                        }
                    };

                    string response = FirebaseMessaging.DefaultInstance.SendAsync(message).Result;

                    Console.WriteLine("Successfully sent message" + response);
                }
            }
            catch (Exception e)
            {
                Console.Write(e.Message);
                if (e.Message.Equals("The default FirebaseApp already exists."))
                {
                    foreach (String registrationToken in tokenTosendNotification)
                    {
                        var message = new Message()
                        {
                            Token = registrationToken,
                            Notification = new Notification()
                            {
                                Title = "Findaa",
                                Body = "New User registered for " + group
                            }
                        };

                        string response = FirebaseMessaging.DefaultInstance.SendAsync(message).Result;

                        Console.WriteLine("Successfully sent message" + response);
                    }
                }
            }
        }
    }
}
